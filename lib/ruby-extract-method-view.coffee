{TextEditorView, View} = require 'atom-space-pen-views'

module.exports =
class RubyExtractMethodView extends View
  @content: ->
    @div class: "ruby-extract-method from-top padded", =>
      @div class: "panel-heading", =>
        @span "Extract selected text to method"
      @div class: "panel-body padded", =>
        @subview 'methodNameEditor', new TextEditorView(mini: true, placeholderText: 'Enter a method name')

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
