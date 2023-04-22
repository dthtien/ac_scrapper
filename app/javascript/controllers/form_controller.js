import { Controller } from "@hotwired/stimulus"
import debounce from "https://cdn.skypack.dev/lodash.debounce"

export default class extends Controller {
  static get targets() { return [ "submit" ] }
  initialize() {
    this.submit = debounce(this.submit.bind(this), 200)
  }

  submit() {
    this.submitTarget.click()
  }

  connect() {
    this.submitTarget.hidden = true
  }
}
