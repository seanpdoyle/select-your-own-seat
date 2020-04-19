import { Controller } from "stimulus"
import svgPanZoom from "svg-pan-zoom"

export default class extends Controller {
  static targets = [
    "loadingOverlay",
    "map",
    "seat",
    "selection",
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
    this.selectSeats()
  }

  disconnect() {
    this.map.destroy()
  }

  zoomIn() {
    this.map.zoomIn()
  }

  zoomOut() {
    this.map.zoomOut()
  }

  selectSeats() {
    const selectedIds = this.selectionTargets.map(seat => seat.dataset.seatId)

    this.seatTargets.forEach(seat => {
      const { seatId, selectedIcon, unselectedIcon } = seat.dataset

      if (selectedIds.includes(seatId)) {
        seat.setAttribute("xlink:href", selectedIcon)
      } else {
        seat.setAttribute("xlink:href", unselectedIcon)
      }
    })
  }
}
