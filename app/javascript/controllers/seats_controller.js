import { Controller } from "stimulus"
import svgPanZoom from "svg-pan-zoom"

export default class extends Controller {
  static targets = [
    "loadingOverlay",
    "map",
    "seat",
    "selection",
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
    this.selectSeats()
  }

  disconnect() {
    if (this.isDiscardingMap) {
      this.map.destroy()
    }
  }

  discardMap() {
    this.mapTarget.removeAttribute("data-turbolinks-permanent")
  }

  get isDiscardingMap() {
    return !this.mapTarget.hasAttribute("data-turbolinks-permanent")
  }

  zoomIn() {
    this.map.zoomIn()
  }

  zoomOut() {
    this.map.zoomOut()
  }

  loadingStarted() {
    if (this.isDiscardingMap) {
      this.loadingOverlayTarget.classList.add("is-loading")
    }
  }

  loadingFinished() {
    this.loadingOverlayTarget.classList.remove("is-loading")
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
