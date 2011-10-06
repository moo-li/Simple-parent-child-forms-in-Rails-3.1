Simple parent-child forms in Rails 3.1
=======================================

This is an attempt to make the simplest possible Rails 3.1 template for nested
forms (i.e. a parent-child relationship between two tables). We aim to
support CRUD actions for both parent and child. You can either download the
template for your project or follow the instructions below to create your own
objects.

We will create Mom and Kid objects. You can create, update and destroy Moms and
Kids. Kids each have one Mom but Moms can have many Kids.

The minimum configuration and coding has been done to make this work. Please let
me have any suggestions for improvements - I'm not a Rails or Ruby expert.

-- Dominic Sayers

Downloading the template app
=============================

1.  `git clone git://github.com/moo-li/Simple-parent-child-forms-in-Rails-3.1.git myapp`
    (where `myapp` is your application name).

1.  `cd myapp`	

1.  `bundle update`

1.  `rails s`

1. Point your browser to `http://localhost:3000/moms`.


Creating your own simple app
=============================

Here's the exact steps I performed to create this app:

1.  At the command prompt, create a new Rails application:
    `rails new myapp` (where `myapp` is your application name). If you want HTML5
    goodness then `rails new myapp -m https://github.com/russfrisch/h5bp-rails/raw/master/h5bp.rb`.

1.  `cd myapp`

1.  `rails g scaffold Mom name:string`

1.  `rails g model Kid name:string mom:references`

1.  Add the following lines to `app/models/mom.rb`

        has_many :kids, :dependent => :destroy
        accepts_nested_attributes_for :kids, :allow_destroy => :true

1.  `rake db:migrate`

1.  In `config/routes.rb`, change `resources :moms` to

        resources :moms do
          resources :kids
        end
  
1.  `rails g controller Kids`

1.  Add the following methods to `app/controllers/kids_controller.rb`

        def create
          @mom = Mom.find(params[:mom_id])
          @kid = @mom.kids.create(params[:kid])
          redirect_to mom_path(@mom)
        end

        def destroy
          @mom = Mom.find(params[:mom_id])
          @kid = @mom.kids.find(params[:id])
          @kid.destroy
          redirect_to mom_path(@mom)
        end

1.  Add the following lines to `app/views/moms/show.html.erb` before the line
    containing `<%= link_to 'Edit', edit_mom_path(@mom) %> |`

        <h2>Kids</h2>
        <%= render @mom.kids %>

        <h3>Add kid</h3>
        <%= render 'kids/form' %>

1.  Create a file `app/views/kids/_kid.html.erb` with the following code:

        <p>
          <strong>Kid:</strong>
          <%= kid.name %>
          <%= link_to 'Remove', [kid.mom, kid], :confirm => 'Really remove kid?', :method => :delete %>
        </p>

1. Create a file `app/views/kids/_form.html.erb` with the following code:

        <%= form_for([@mom, @mom.kids.build]) do |f| %>
          <div class="field">
            <%= f.label :name %> <%= f.text_field :name %>
          </div>

          <div class="actions">
            <%= f.submit %>
          </div>
        <% end %>

1. `rails s`

1. Point your browser to `http://localhost:3000/moms`.
