import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["state", "city"]

    connect() {
        if (this.stateTarget.value) {
            this.loadCities()
        }
    }

    loadCities() {
        const stateId = this.stateTarget.value

        fetch(`/locations/cities?state_id=${stateId}`)
            .then(response => response.json())
            .then(cities => {
                this.cityTarget.innerHTML = "<option value=''>Select a city</option>"
                cities.forEach(city => {
                    const option = document.createElement("option")
                    option.value = city.name
                    option.textContent = city.name
                    this.cityTarget.appendChild(option)
                })
            })
    }
}
