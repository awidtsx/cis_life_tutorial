import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "amount",
    "rate",
    "effectivity",
    "expiry",
    "premiumPreview",
    "premiumInput"
  ]
  
  connect() {
    console.log("Premium controller connected!")
  }
  
  recalculate() {
    console.log("recalculate called")
    
    // Guard clause
    if (!this.effectivityTarget.value || !this.expiryTarget.value) {
      this.premiumPreviewTarget.textContent = "-"
      this.premiumInputTarget.value = ""
      return
    }

    const start = new Date(this.effectivityTarget.value)
    const end   = new Date(this.expiryTarget.value)

    // Calculate term (months)
    const term =
      (end.getFullYear() * 12 + end.getMonth()) -
      (start.getFullYear() * 12 + start.getMonth())

    if (term <= 0) {
      this.premiumPreviewTarget.textContent = "-"
      this.premiumInputTarget.value = ""
      return
    }

    const amount = parseFloat(this.amountTarget.value || 0)
    
    // Get rate value - could be from select or custom input
    let rate = 0
    
    // Check if custom rate input exists (for individual contracts)
    const customRateInput = document.getElementById('custom_rate_input')
    if (customRateInput && customRateInput.value) {
      rate = parseFloat(customRateInput.value || 0)
    } else if (this.hasRateTarget) {
      // Try to get from select dropdown
      const selectedOption = this.rateTarget.selectedOptions[0]
      if (selectedOption) {
        rate = parseFloat(selectedOption.text || 0)
      }
    }

    const premium = (amount / 1000) * rate * term

    this.premiumPreviewTarget.textContent =
      premium.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })

    this.premiumInputTarget.value = premium.toFixed(2)
  }
}