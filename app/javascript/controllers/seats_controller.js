import { Controller } from "stimulus"
import svgPanZoom from "svg-pan-zoom"

export default class extends Controller {
  static targets = [
    "map",
  ]

  connect() {
    this.map = svgPanZoom(this.mapTarget, {
      viewportSelector: "#map-viewport",
      center: true,
      fit: true,
      zoomEnabled: false,
      zoomScaleSensitivity: 0.75,
      minZoom: 1.0,
      maxZoom: 8,
    })
  }

  disconnect() {
    if (!this.mapTarget.hasAttribute("data-turbolinks-permanent")) {
      this.map.destroy()
    }
  }

  discardMap() {
    this.mapTarget.removeAttribute("data-turbolinks-permanent")
  }

  zoomIn() {
    this.map.zoomIn()
  }

  zoomOut() {
    this.map.zoomOut()
  }
}
