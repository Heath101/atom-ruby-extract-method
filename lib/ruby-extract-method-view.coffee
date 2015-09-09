module.exports =
class RubyExtractMethodView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('ruby-extract-method')


    # Create message element
    message = document.createElement('div')
    message.textContent = "The RubyExtractMethod package is Alive! It's ALIVE!"
    message.classList.add('message')
    methodName = document.createElement('input')

    @element.appendChild(message)
    @element.appendChild(methodName)


  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
