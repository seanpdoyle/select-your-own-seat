import { Controller } from "stimulus"

export default class extends Controller {
  apply({ target }) {
    const maximum = target.value
    const currentUrl = new URL(document.location)

    if (maximum) {
      currentUrl.searchParams.set("maximum", maximum)
    } else {
      currentUrl.searchParams.delete("maximum")
    }

    history.replaceState({}, "", currentUrl)

    this.data.set("maximum", maximum)
  }
}
