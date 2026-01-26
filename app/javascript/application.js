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
// Agreement Contract Type Toggle and Product Filtering (No TomSelect)
// Agreement Contract Type Toggle and Product Filtering (No TomSelect)
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
  
  // Add change listener to contract type
  typeSelect.addEventListener('change', function() {
    toggleFieldsAndUpdateProducts(this.value)
  })
  
  // Add change listeners for validation
  if (cooperativeSelect) {
    cooperativeSelect.addEventListener('change', validateForm)
  }
  
  if (individualSelect) {
    individualSelect.addEventListener('change', validateForm)
  }
  
  if (productSelect) {
    productSelect.addEventListener('change', validateForm)
  }
  
  // Initialize on page load
  if (typeSelect.value) {
    toggleFieldsAndUpdateProducts(typeSelect.value)
  }
  
  function toggleFieldsAndUpdateProducts(selectedType) {
    console.log('Selected type:', selectedType)
    
    if (selectedType === 'Cooperative') {
      cooperativeField.style.display = 'block'
      individualField.style.display = 'none'
      
      if (cooperativeSelect) cooperativeSelect.disabled = false
      if (individualSelect) {
        individualSelect.disabled = true
        individualSelect.value = ''
      }
      
      updateProductOptions('group_policy')
      
    } else if (selectedType === 'Individual') {
      cooperativeField.style.display = 'none'
      individualField.style.display = 'block'
      
      if (individualSelect) individualSelect.disabled = false
      if (cooperativeSelect) {
        cooperativeSelect.disabled = true
        cooperativeSelect.value = ''
      }
      
      updateProductOptions('individual')
      
    } else {
      cooperativeField.style.display = 'none'
      individualField.style.display = 'none'
      
      if (cooperativeSelect) cooperativeSelect.disabled = true
      if (individualSelect) individualSelect.disabled = true
      
      clearProductOptions()
    }
    
    validateForm()
  }
  
  function updateProductOptions(productType) {
    console.log('Updating products for type:', productType)
    console.log('All available products:', allProducts)
    
    // Save current selection
    const currentValue = productSelect.value
    
    // Clear all options
    productSelect.innerHTML = ''
    
    // Add prompt option
    const promptOption = document.createElement('option')
    promptOption.value = ''
    promptOption.textContent = 'Select a product'
    productSelect.appendChild(promptOption)
    
    // Filter products by type - match exactly what's in the database
    const filteredProducts = allProducts.filter(p => {
      console.log('Checking product:', p.name, 'with type:', p.product_type, 'against:', productType)
      return p.product_type === productType
    })
    console.log('Filtered products:', filteredProducts)
    
    if (filteredProducts.length === 0) {
      const noProductOption = document.createElement('option')
      noProductOption.value = ''
      noProductOption.textContent = 'No ' + (productType === 'group_policy' ? 'Group' : 'Individual') + ' products available'
      productSelect.appendChild(noProductOption)
      productSelect.disabled = true
      
      if (productHelp) {
        productHelp.textContent = 'No ' + (productType === 'group_policy' ? 'Group' : 'Individual') + ' products found. Please create one first.'
        productHelp.classList.add('text-danger')
        productHelp.classList.remove('text-success')
      }
      
      if (submitButton) submitButton.disabled = true
      
    } else {
      // Add filtered products
      filteredProducts.forEach(product => {
        const option = document.createElement('option')
        option.value = product.id
        option.textContent = product.name
        productSelect.appendChild(option)
      })
      
      productSelect.disabled = false
      
      // Restore selection if it's still valid
      if (currentValue && filteredProducts.some(p => p.id == currentValue)) {
        productSelect.value = currentValue
      } else if (currentProductId && filteredProducts.some(p => p.id == currentProductId)) {
        productSelect.value = currentProductId
      }
      
      if (productHelp) {
        productHelp.textContent = 'Only ' + (productType === 'group_policy' ? 'Group' : 'Individual') + ' products are shown'
        productHelp.classList.remove('text-danger')
        productHelp.classList.add('text-success')
      }
      
      if (submitButton) submitButton.disabled = false
    }
  }
  
  function clearProductOptions() {
    // Clear all options
    productSelect.innerHTML = ''
    
    // Add prompt option
    const promptOption = document.createElement('option')
    promptOption.value = ''
    promptOption.textContent = 'First select contract type'
    productSelect.appendChild(promptOption)
    
    productSelect.disabled = true
    
    if (productHelp) {
      productHelp.textContent = 'Select the insurance product for this contract'
      productHelp.classList.remove('text-danger', 'text-success')
    }
  }
  
  function validateForm() {
    const selectedType = typeSelect.value
    const selectedCooperative = cooperativeSelect?.value
    const selectedIndividual = individualSelect?.value
    const selectedProduct = productSelect.value
    
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
}