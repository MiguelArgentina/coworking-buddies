import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [
        "results",
        "streetName",
        "streetNumber",
        "city",
        "state",
        "country"
    ]

    connect() {
        const mapEl = document.getElementById("map")
        if (!mapEl) {
            console.warn("Map container not found. Skipping map setup.")
            return
        }

        this.map = L.map("map").setView([-34.6037, -58.3816], 13)
        L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
            maxZoom: 19,
            attribution: "© OpenStreetMap"
        }).addTo(this.map)

        this.markers = []

        // Auto-trigger geocode if address fields are filled (e.g., on edit)
        if (
            this.streetNameTarget?.value &&
            this.streetNumberTarget?.value &&
            this.cityTarget?.value &&
            this.stateTarget?.value &&
            this.countryTarget?.value
        ) {
            this.refreshAddress()
        }
    }

    refreshAddress() {
        const parts = [
            this.streetNameTarget?.value,
            this.streetNumberTarget?.value,
            this.cityTarget?.value,
            this.stateTarget?.selectedOptions?.[0]?.text,
            this.countryTarget?.selectedOptions?.[0]?.text
        ].filter(Boolean)

        const address = parts.join(", ")
        if (parts.length > 4) {
            this.geocode(address)
        }
    }

    async geocode(address) {
        const url = `/locations/lookups/geocode?q=${encodeURIComponent(address)}`
        const response = await fetch(url)
        const data = await response.json()

        const previouslySelected = this.resultsTarget.value
        this.resultsTarget.innerHTML = `<option value="">Choose a location</option>`

        if (!this.map) {
            console.warn("Map is not initialized. Skipping rendering markers.")
            return
        }

        if (this.markers) {
            this.markers.forEach(m => this.map.removeLayer(m))
        }
        this.markers = []

        data.forEach((result, index) => {
            const option = document.createElement("option")
            option.value = `${result.lat},${result.lon}`
            option.text = `${index + 1}. ${result.display_name}`

            if (option.value === previouslySelected) {
                option.selected = true
            }

            this.resultsTarget.appendChild(option)

            const marker = L.marker([result.lat, result.lon])
                .addTo(this.map)
                .bindTooltip(`${index + 1}`, {
                    permanent: true,
                    direction: "top",
                    className: "marker-label"
                })

            this.markers.push(marker)
        })

        if (this.markers.length > 0) {
            const selected = this.resultsTarget.value
            if (selected) {
                const [lat, lon] = selected.split(",").map(Number)
                this.map.setView([lat, lon], 16)
            } else {
                const group = L.featureGroup(this.markers)
                this.map.fitBounds(group.getBounds().pad(0.2))
            }
        } else {
            console.warn("No geocoding results returned — skipping map update.")
        }
    }

    selectLocation(event) {
        const coords = event.target.value
        if (!coords) return

        const [lat, lon] = coords.split(",")
        document.getElementById("selected-latitude").value = lat
        document.getElementById("selected-longitude").value = lon

        this.map.setView([lat, lon], 16)
    }
}
