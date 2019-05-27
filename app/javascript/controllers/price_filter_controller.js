import { Controller } from "stimulus"

export default class extends Controller {
  apply({ target }) {
    const maximum = target.value

    this.data.set("maximum", maximum)
  }
}
