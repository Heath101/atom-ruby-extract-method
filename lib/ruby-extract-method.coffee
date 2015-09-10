RubyExtractMethodView = require './ruby-extract-method-view'
{CompositeDisposable} = require 'atom'

module.exports = RubyExtractMethod =
  rubyExtractMethodView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @rubyExtractMethodView = new RubyExtractMethodView(state.rubyExtractMethodViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @rubyExtractMethodView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ruby-extract-method:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @rubyExtractMethodView.destroy()

  serialize: ->
    rubyExtractMethodViewState: @rubyExtractMethodView.serialize()

  toggle: ->
    console.log 'RubyExtractMethod was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
