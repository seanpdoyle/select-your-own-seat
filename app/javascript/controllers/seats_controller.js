import { Controller } from "stimulus"
import svgPanZoom from "svg-pan-zoom"

export default class extends Controller {
  static targets = [
    "loadingOverlay",
    "map",
    "seat",
    "section",
    "selection",
    "viewport",
    "zoomControls",
  ]

  connect() {
    this.zoomControlsTarget.hidden = false
    this.map = svgPanZoom(this.mapTarget, {
      viewportSelector: "#map-viewport",
      center: true,
      fit: true,
      zoomEnabled: false,
      zoomScaleSensitivity: 0.75,
      minZoom: 1.0,
      maxZoom: 8,
    })

    const mapState = this.readMapState()
    if (mapState) {
      const [ zoom, pan ] = mapState

      this.map.zoom(zoom)
      this.map.pan(pan)
    }

    this.selectSeats()
  }

  disconnect() {
    this.writeMapState(this.map)

    this.map.destroy()
  }

  writeMapState(map) {
    const floorId = this.data.get("floorId")

    const state = [map.getZoom(), map.getPan()]

    window.sessionStorage.setItem(`${floorId}.state`, JSON.stringify(state))
  }

  readMapState() {
    const floorId = this.data.get("floorId")

    const state = window.sessionStorage.getItem(`${floorId}.state`)

    try {
      return JSON.parse(state)
    } catch (_) {
      return null
    }
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

  filterSeats({ currentTarget }) {
    const price = currentTarget.value
    const maximum = Number(price || Infinity)
    const currentUrl = new URL(document.location)

    if (maximum !== Infinity) {
      currentUrl.searchParams.set("maximum", maximum)
      history.pushState({ maximum }, "", currentUrl)
    } else {
      currentUrl.searchParams.delete("maximum")
      history.replaceState({}, "", currentUrl)
    }

    this.sectionTargets.
      filter(section => Number(section.dataset.price) > maximum).
      forEach(section => {
        const { excludedOpacity } = section.dataset

        section.setAttribute("opacity", excludedOpacity)
        section.setAttribute("aria-hidden", true)
      })

    this.sectionTargets.
      filter(section => Number(section.dataset.price) <= maximum).
      forEach(section => {
        const { includedOpacity } = section.dataset

        section.setAttribute("opacity", includedOpacity)
        section.removeAttribute("aria-hidden")
      })
  }
}
