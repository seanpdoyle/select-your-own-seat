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

    if (this.mapState[this.floor]) {
      const { zoom, x, y } = this.mapState[this.floor]

      this.map.zoom(zoom)
      this.map.pan({ x, y })
    }
  }

  disconnect() {
    if (this.mapStateElement) {
      const zoom = this.map.getZoom()
      const { x, y } = this.map.getPan()

      this.mapStateElement.content = JSON.stringify({
        [this.floor]: { zoom, x, y },
        ...this.mapState,
      })
    }

    this.map.destroy()
  }

  get floor() {
    return this.data.get("floor")
  }

  get mapStateElement() {
    return document.querySelector(this.data.get("mapStateElement"))
  }

  get mapState() {
    try {
      return JSON.parse(this.mapStateElement.content)
    } catch(_) {
      return {}
    }

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
