KeluaranHkView = require './keluaran-hk-view'
{CompositeDisposable} = require 'atom'

module.exports = KeluaranHk =
  keluaranHkView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @keluaranHkView = new KeluaranHkView(state.keluaranHkViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @keluaranHkView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'keluaran-hk:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @keluaranHkView.destroy()

  serialize: ->
    keluaranHkViewState: @keluaranHkView.serialize()

  toggle: ->
    console.log 'KeluaranHk was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
