// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"  // this imports controllers/index.js
import TomSelect from "tom-select"
import 'bootstrap'


document.addEventListener("DOMContentLoaded", () => {
  const regionEl = document.getElementById("region_select")
  const provinceEl = document.getElementById("province_select")
  const municipalEl = document.getElementById("municipal_select")
  const barangayEl = document.getElementById("barangay_select")

  if (regionEl && provinceEl) {
    // Province TomSelect FIRST

    const barangayTom = new TomSelect(barangayEl, {
      placeholder: "Select a barangay",
      allowEmptyOption: true
    })
    
    barangayTom.disable();

    const municipalTom = new TomSelect(municipalEl, {
      placeholder: "Select a municipal",
      allowEmptyOption: true,
      onChange(municipalId) {
        barangayTom.clear(true)
        barangayTom.clearOptions()
        barangayTom.disable()

        if (!municipalId) return

        fetch(`/cooperatives/barangays_for_municipal.json?add_municipal_id=${municipalId}`)
          .then(res => res.json())
          .then(barangays => {
            barangays.forEach(b => {
              barangayTom.addOption({
                value: b.id,
                text: b.name
              })
            })

            barangayTom.enable()
            barangayTom.refreshOptions(false)
          })
      }
    })
    
    municipalTom.disable()

    const provinceTom = new TomSelect(provinceEl, {
      placeholder: "Select a province",
      allowEmptyOption: true,
      onChange(provinceId) {
        municipalTom.clear(true)
        municipalTom.clearOptions()
        municipalTom.disable()

        if (!provinceId) return

        fetch(`/cooperatives/municipals_for_province.json?add_province_id=${provinceId}`)
          .then(res => res.json())
          .then(municipals => {
            municipals.forEach(m => {
              municipalTom.addOption({
                value: m.id,
                text: m.name
              })
            })

            municipalTom.enable()
            municipalTom.refreshOptions(false)
          })
      }
    })

    // Disable province until region selected
    provinceTom.disable()

    new TomSelect(regionEl, {
      placeholder: "Select a region",
      allowEmptyOption: true,
      onChange(regionId) {
        provinceTom.clear(true)
        provinceTom.clearOptions()
        provinceTom.disable()

        if (!regionId) return

        fetch(`/cooperatives/provinces_for_region.json?add_region_id=${regionId}`)
          .then(res => res.json())
          .then(provinces => {
            provinces.forEach(p => {
              provinceTom.addOption({
                value: p.id,
                text: p.name
              })
            })

            provinceTom.enable()
            provinceTom.refreshOptions(false)
          })
      }
    })
  }
})

// Contract Type Toggle for Polymorphic Contractable
document.addEventListener("turbo:load", initContractTypeToggle)
document.addEventListener("DOMContentLoaded", initContractTypeToggle)

function initContractTypeToggle() {
  const typeSelect = document.getElementById('contractable_type_select')
  const cooperativeField = document.getElementById('cooperative_field')
  const individualField = document.getElementById('individual_field')
  
  if (!typeSelect || !cooperativeField || !individualField) return
  
  function toggleFields() {
    const selectedType = typeSelect.value
    
    if (selectedType === 'Cooperative') {
      cooperativeField.style.display = 'block'
      individualField.style.display = 'none'
    } else if (selectedType === 'Individual') {
      cooperativeField.style.display = 'none'
      individualField.style.display = 'block'
    } else {
      cooperativeField.style.display = 'none'
      individualField.style.display = 'none'
    }
  }
  
  typeSelect.addEventListener('change', toggleFields)
  toggleFields() // Initialize on page load
}

// Agreement Type Toggle for Polymorphic Agreement (Insurance Contracts)
document.addEventListener("turbo:load", initAgreementTypeToggle)
document.addEventListener("DOMContentLoaded", initAgreementTypeToggle)

function initAgreementTypeToggle() {
  const agreementTypeSelect = document.getElementById('agreement_type_select')
  const rateField = document.getElementById('rate_field')
  const contractField = document.getElementById('contract_field')
  
  if (!agreementTypeSelect || !rateField || !contractField) return
  
  function toggleAgreementFields() {
    const selectedType = agreementTypeSelect.value
    
    if (selectedType === 'Agreement::Rate') {
      rateField.style.display = 'block'
      contractField.style.display = 'none'
    } else if (selectedType === 'Agreement::Contract') {
      rateField.style.display = 'none'
      contractField.style.display = 'block'
    } else {
      rateField.style.display = 'none'
      contractField.style.display = 'none'
    }
  }
  
  agreementTypeSelect.addEventListener('change', toggleAgreementFields)
  toggleAgreementFields() // Initialize on page load
}

// Agreement Contract Type Toggle and Product Filtering
document.addEventListener("turbo:load", initAgreementContractForm)
document.addEventListener("DOMContentLoaded", initAgreementContractForm)

function initAgreementContractForm() {
  const contractForm = document.getElementById('contract_form')
  if (!contractForm) return
  
  const typeSelect = document.getElementById('contractable_type_select')
  const cooperativeField = document.getElementById('cooperative_field')
  const individualField = document.getElementById('individual_field')
  const cooperativeSelect = document.getElementById('cooperative_select')
  const individualSelect = document.getElementById('individual_select')
  const productSelect = document.getElementById('product_select')
  const productHelp = document.getElementById('product_help')
  const warningDiv = document.getElementById('product_type_warning')
  const warningMessage = document.getElementById('warning_message')
  const submitButton = document.getElementById('submit_button')
  
  if (!typeSelect || !productSelect) return
  
  // Get all products from data attribute
  const allProducts = JSON.parse(productSelect.dataset.products || '[]')
  const currentProductId = productSelect.dataset.currentProduct
  
  console.log('All products:', allProducts)
  console.log('Current product ID:', currentProductId)
  
  // Initialize TomSelect instances
  let typeTomSelect = null
  let cooperativeTomSelect = null
  let individualTomSelect = null
  let productTomSelect = null
  
  // Wait for TomSelect to be initialized
  setTimeout(() => {
    typeTomSelect = typeSelect.tomselect
    cooperativeTomSelect = cooperativeSelect?.tomselect
    individualTomSelect = individualSelect?.tomselect
    productTomSelect = productSelect.tomselect
    
    if (typeTomSelect) {
      typeTomSelect.on('change', function(value) {
        toggleFieldsAndUpdateProducts(value)
      })
    }
    
    // Initialize on page load
    if (typeSelect.value) {
      toggleFieldsAndUpdateProducts(typeSelect.value)
    }
  }, 100)
  
  function toggleFieldsAndUpdateProducts(selectedType) {
    console.log('Selected type:', selectedType)
    
    if (selectedType === 'Cooperative') {
      cooperativeField.style.display = 'block'
      individualField.style.display = 'none'
      
      if (cooperativeTomSelect) cooperativeTomSelect.enable()
      if (individualTomSelect) {
        individualTomSelect.disable()
        individualTomSelect.clear()
      }
      
      updateProductOptions('Group')
      
    } else if (selectedType === 'Individual') {
      cooperativeField.style.display = 'none'
      individualField.style.display = 'block'
      
      if (individualTomSelect) individualTomSelect.enable()
      if (cooperativeTomSelect) {
        cooperativeTomSelect.disable()
        cooperativeTomSelect.clear()
      }
      
      updateProductOptions('Individual')
      
    } else {
      cooperativeField.style.display = 'none'
      individualField.style.display = 'none'
      
      if (cooperativeTomSelect) cooperativeTomSelect.disable()
      if (individualTomSelect) individualTomSelect.disable()
      
      clearProductOptions()
    }
    
    validateForm()
  }
  
  function updateProductOptions(productType) {
    console.log('Updating products for type:', productType)
    
    if (!productTomSelect) return
    
    // Save current selection
    const currentValue = productTomSelect.getValue()
    
    // Clear all options
    productTomSelect.clearOptions()
    productTomSelect.clear()
    
    // Filter products by type
    const filteredProducts = allProducts.filter(p => p.product_type === productType)
    console.log('Filtered products:', filteredProducts)
    
    if (filteredProducts.length === 0) {
      productTomSelect.addOption({
        value: '',
        text: 'No ' + productType + ' products available'
      })
      productTomSelect.disable()
      
      if (productHelp) {
        productHelp.textContent = 'No ' + productType + ' products found. Please create one first.'
        productHelp.classList.add('text-danger')
        productHelp.classList.remove('text-success')
      }
      
      if (submitButton) submitButton.disabled = true
      
    } else {
      // Add filtered products
      filteredProducts.forEach(product => {
        productTomSelect.addOption({
          value: product.id,
          text: product.name
        })
      })
      
      productTomSelect.enable()
      
      // Restore selection if it's still valid
      if (currentValue && filteredProducts.some(p => p.id == currentValue)) {
        productTomSelect.setValue(currentValue, true)
      } else if (currentProductId && filteredProducts.some(p => p.id == currentProductId)) {
        productTomSelect.setValue(currentProductId, true)
      }
      
      if (productHelp) {
        productHelp.textContent = 'Only ' + productType + ' products are shown'
        productHelp.classList.remove('text-danger')
        productHelp.classList.add('text-success')
      }
      
      if (submitButton) submitButton.disabled = false
    }
    
    productTomSelect.refreshOptions(false)
  }
  
  function clearProductOptions() {
    if (!productTomSelect) return
    
    productTomSelect.clearOptions()
    productTomSelect.clear()
    productTomSelect.addOption({
      value: '',
      text: 'First select contract type'
    })
    productTomSelect.disable()
    
    if (productHelp) {
      productHelp.textContent = 'Select the insurance product for this contract'
      productHelp.classList.remove('text-danger', 'text-success')
    }
  }
  
  function validateForm() {
    if (!typeTomSelect || !productTomSelect) return
    
    const selectedType = typeTomSelect.getValue()
    const selectedCooperative = cooperativeTomSelect?.getValue()
    const selectedIndividual = individualTomSelect?.getValue()
    const selectedProduct = productTomSelect.getValue()
    
    let isValid = true
    let message = ''
    
    if (!selectedType) {
      isValid = false
      message = 'Please select a contract type'
    } else if (selectedType === 'Cooperative' && !selectedCooperative) {
      isValid = false
      message = 'Please select a cooperative'
    } else if (selectedType === 'Individual' && !selectedIndividual) {
      isValid = false
      message = 'Please select an individual'
    } else if (!selectedProduct) {
      isValid = false
      message = 'Please select an insurance product'
    }
    
    if (warningDiv && warningMessage && submitButton) {
      if (!isValid) {
        warningDiv.style.display = 'block'
        warningMessage.textContent = message
        submitButton.disabled = true
      } else {
        warningDiv.style.display = 'none'
        submitButton.disabled = false
      }
    }
    
    return isValid
  }
  
  // Add change listeners for validation
  if (cooperativeTomSelect) {
    cooperativeTomSelect.on('change', validateForm)
  }
  
  if (individualTomSelect) {
    individualTomSelect.on('change', validateForm)
  }
  
  if (productTomSelect) {
    productTomSelect.on('change', validateForm)
  }
}