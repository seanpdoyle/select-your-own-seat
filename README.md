Select Your Own Seat
===

This application is an example of how to develop an interactive web page using:

* Rails
* Rails' Unobtrustive JavaScript
* Turbolinks
* StimulusJS

The commit history is intentionally meticulous and verbose. 

The intent behind this repository is to:

* serve as an example of real-world application built in a server-rendered
  monolith
* demonstrate how to iteratively build up a set of features over time, starting
  with boring standards based HTML, then extending that behavior with JavaScript
* demonstrate how and when to progressively enhance a feature that works outside
  of a JavaScript-capable browser environment

When creating this repository, deliberate effort was exerted to strike a balance
between:

* explicit and verbose (HTML, model, controller) code  *versus* "clean" and
  well-factored Rails code
* newer, terser JavaScript syntax (arrow functions, destructuring, etc) *versus*
  more familiar, approachable syntax
* small and focussed diffs that represent the minimal amount of changes
  necessary to integrate with newer libraries and concepts *versus* real-world
  feature-development style commits
* emphasizing outside-in, test-driven developed, production-ready code *versus*
  emphasizing educational and approachable implementation code

Some other things to note:

* The data model is inspired by a real-world application, but simplified for the
  sake of demonstration
* The CSS, while important and worth explaining on its own, is treated as a
  peripheral implementation detail
* One of the original project's areas of focus was accessibility. For the sake
  of this demonstration, most of the accessibility work involved in the original
  project has been omitted
* The number of both JavaScript and Ruby dependencies is intentionally limited
* The project uses Rails defaults as much as possible (i.e. MiniTest instead of
  RSpec, [`CurrentAttributes`][CurrentAttributes], `form_with` instead of
`simple_form`, etc)
* There is no internationalization. Page's copy and labels are hard-coded
  directly into the HTML
* There are additional optimizations that could be made for the sake of
  performance. Those optimizations have been omitted from this repository

[CurrentAttributes]: https://api.rubyonrails.org/classes/ActiveSupport/CurrentAttributes.html

Development
---

To develop the application locally, check it out with `git` then run the setup
script:

```bash
$ git clone git@github.com:seanpdoyle/select-your-own-seat.git
$ cd select-your-own-seat
$ bin/setup
$ rails server
```

Once the `rails server` command is running, visit the page at
<http://localhost:3000>.
