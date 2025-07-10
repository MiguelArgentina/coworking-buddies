import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["country", "state"]

    connect() {
        if (this.countryTarget.value) {
            this.loadStates()
        }
    }

    loadStates() {
        const countryId = this.countryTarget.value

        fetch(`/locations/states?country_id=${countryId}`)
            .then(response => response.json())
            .then(states => {
                this.stateTarget.innerHTML = "<option value=''>Select a state or province</option>"
                states.forEach(state => {
                    const option = document.createElement("option")
                    option.value = state.id
                    option.textContent = state.name
                    this.stateTarget.appendChild(option)
                })
            })
    }
}
