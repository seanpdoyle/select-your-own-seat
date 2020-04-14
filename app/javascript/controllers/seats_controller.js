import { Controller } from "stimulus"
import svgPanZoom from "svg-pan-zoom"

export default class extends Controller {
  static targets = [
    "loadingOverlay",
    "map",
    "seat",
    "section",
    "selection",
    "zoomControls",
  ]

  connect() {
    const mapState = document.querySelector('meta[name="map-state"]')
    this.zoomControlsTarget.hidden = false
    this.map = svgPanZoom(this.mapTarget, {
      center: true,
      fit: true,
      zoomEnabled: false,
      zoomScaleSensitivity: 0.75,
      minZoom: 1.0,
      maxZoom: 8,
    })

    this.removeNoscriptSeats()
    this.selectSeats()
    this.element.classList.remove(this.data.get("noscriptClass"))
  }

  removeNoscriptSeats() {
    if (this.element.classList.contains(this.data.get("noscriptClass"))) {
      this.seatTargets.forEach(seat => {
        if (seat.getAttribute("xlink:href") === "#seat-icon-selected") {
          seat.remove()
        }
      })
    }
  }

  disconnect() {
    const mapState = document.querySelector('meta[name="map-state"]')

    if (mapState) {
      mapState.setAttribute("content", JSON.stringify({ pan, zoom }))
    }

    this.map.destroy()
  }

  zoomIn() {
    this.map.zoomIn()
  }

  zoomOut() {
    this.map.zoomOut()
  }

  loadingStarted() {
    this.loadingOverlayTarget.classList.add(this.data.get("loadingClass"))
  }

  loadingFinished() {
    this.loadingOverlayTarget.classList.remove(this.data.get("loadingClass"))
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
