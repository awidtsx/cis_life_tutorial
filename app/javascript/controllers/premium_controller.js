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
    // guard clause
    console.log("recalculate called")
    if (!this.effectivityTarget.value || !this.expiryTarget.value) {
      this.premiumPreviewTarget.textContent = "-"
      this.premiumInputTarget.value = ""
      return
    }

    const start = new Date(this.effectivityTarget.value)
    const end   = new Date(this.expiryTarget.value)

    // calculate term (months)
    const term =
      (end.getFullYear() * 12 + end.getMonth()) -
      (start.getFullYear() * 12 + start.getMonth())

    if (term <= 0) {
      this.premiumPreviewTarget.textContent = "-"
      this.premiumInputTarget.value = ""
      return
    }

    const amount = parseFloat(this.amountTarget.value || 0)
    const rate   = parseFloat(
      this.rateTarget.selectedOptions[0]?.text || 0
    )

    const premium = (amount / 1000) * rate * term

    this.premiumPreviewTarget.textContent =
      premium.toLocaleString(undefined, { minimumFractionDigits: 2 })

    this.premiumInputTarget.value = premium.toFixed(2)
  }
}
