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

  if (!regionEl || !provinceEl) return

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
})