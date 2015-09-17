RubyExtractMethodView = require './ruby-extract-method-view'
{CompositeDisposable, TextBuffer} = require 'atom'

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
    @subscriptions.add atom.commands.add 'div.ruby-extract-method', 'core:confirm':      => @extract()
    @subscriptions.add atom.commands.add 'div.ruby-extract-method', 'core:cancel':       => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @rubyExtractMethodView.destroy()

  serialize: ->
    rubyExtractMethodViewState: @rubyExtractMethodView.serialize()

  toggle: ->
    if @modalPanel.isVisible()
      @rubyExtractMethodView.methodNameEditor.setText("")
      @pane.activate() if @pane
      @modalPanel.hide()
    else
      @modalPanel.show()
      @rubyExtractMethodView.methodNameEditor.focus()

  extract: ->
    activeEditor = atom.workspace.getActiveTextEditor()
    @pane = atom.workspace.getActivePane()
    methodBody = activeEditor.getSelectedText()
    methodName = @rubyExtractMethodView.methodNameEditor.getText()
    rubyMethod =  "def #{methodName}\n    #{methodBody}\n  end"
    activeEditor.insertText(methodName)
    atom.clipboard.write(rubyMethod, "extracted method definition")
    @toggle()
