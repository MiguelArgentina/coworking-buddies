import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "toggle"]

    connect() {
        this.showing = false
        this.updateToggle()
    }

    toggle() {
        this.showing = !this.showing
        this.inputTarget.type = this.showing ? "text" : "password"
        this.updateToggle()
    }

    updateToggle() {
        this.toggleTarget.textContent = this.showing ? "👁️" : "🙈"
    }
}
