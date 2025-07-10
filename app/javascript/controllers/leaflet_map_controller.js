import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = {
        latitude: Number,
        longitude: Number,
        name: String
    }

    connect() {
        this.loadLeaflet()
            .then(() => this.initMap())
            .catch((error) => console.error("Leaflet failed to load:", error));
    }

    loadLeaflet() {
        return new Promise((resolve, reject) => {
            if (window.L) return resolve();

            // Prevent double loading
            if (document.querySelector('script[data-leaflet]')) return resolve();

            // Load Leaflet CSS
            const leafletCss = document.createElement('link');
            leafletCss.rel = 'stylesheet';
            leafletCss.href = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css';
            leafletCss.setAttribute('data-leaflet', 'true');
            document.head.appendChild(leafletCss);

            // Load Leaflet JS
            const leafletScript = document.createElement('script');
            leafletScript.src = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.js';
            leafletScript.setAttribute('data-leaflet', 'true');
            leafletScript.onload = () => resolve();
            leafletScript.onerror = reject;

            document.head.appendChild(leafletScript);
        });
    }

    initMap() {
        const L = window.L;
        const map = L.map(this.element).setView(
            [this.latitudeValue, this.longitudeValue],
            16
        );

        L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
            attribution:
                '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        L.marker([this.latitudeValue, this.longitudeValue])
            .addTo(map)
            .bindPopup(this.nameValue)
            .openPopup();
    }
}
