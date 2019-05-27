import { Controller } from "stimulus"
import svgPanZoom from "svg-pan-zoom"

export default class extends Controller {
  static targets = [
    "map",
    "zoomControls",
  ]

  connect() {
    this.zoomControlsTarget.hidden = false
    this.map = svgPanZoom(this.mapTarget, {
      zoomEnabled: false,
      zoomScaleSensitivity: 0.75,
      minZoom: 1.0,
      maxZoom: 8,
    })
  }

  disconnect() {
    this.map.destroy()
  }
}
