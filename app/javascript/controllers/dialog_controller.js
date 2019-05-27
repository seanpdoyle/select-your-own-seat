import { Controller } from "stimulus"
import Turbolinks from "turbolinks"

export default class extends Controller {
  cancel({ currentTarget }) {
    const { redirectToUrl } = currentTarget.dataset

    Turbolinks.visit(redirectToUrl, { action: "replace" })
  }
}
