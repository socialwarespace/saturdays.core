class Saturdays.View extends Backbone.View

	template: null
	templates: null

	data: {}
	events: {}


	initialize: ->
		this.listenTo Saturdays.session, "sync", this.render if Saturdays.session?
		this.listenTo Saturdays.user, "sync", this.render if Saturdays.user?

		_.extend @data, 
			pieces: window.pieces
			current_path: window.current_path


		this.render()




	render: ->
		_.extend @data, 
			session: Saturdays.session.toJSON() if Saturdays.session?
			user: Saturdays.user.toJSON() if Saturdays.user?
			is_authenticated: Saturdays.session.has("user_id") if Saturdays.session?
			is_admin: Saturdays.user.get("is_admin") if Saturdays.user?

		if @templates?
			html = ""
			_.each @templates, (template)=>
				html += template(@data)

			this.$el.html(html)
			
		else
			this.$el.html @template(@data) if @template?


		super()

		$(document.links).filter(()->
			this.hostname != window.location.hostname
		).attr('target', '_blank')

		this.delegateEvents()

		this

