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

Getting Started
================

1. At the command prompt, create a new Rails application:
`rails new myapp` (where `myapp` is the application name). If you want HTML5
goodness then `rails new myapp -m https://github.com/russfrisch/h5bp-rails/raw/master/h5bp.rb`.

2. `cd myapp`

3. `rails g scaffold Mom name:string`

4. `rails g model Kid name:string mom:references`

5. Add the following lines to `app/models/mom.rb`<pre>

  has_many :kids, :dependent => :destroy
  accepts_nested_attributes_for :kids, :allow_destroy => :true</pre>

6. `rake db:migrate`

7. In `config/routes.rb`, change `resources :moms` to

<pre>  resources :moms do
    resources :kids
  end</pre>
  
8. `rails g controller Kids`

9. Add the following methods to `app/controllers/kids_controller.rb`

<pre>  def create
    @mom = Mom.find(params[:mom_id])
    @kid = @mom.kids.create(params[:kid])
    redirect_to mom_path(@mom)
  end

  def destroy
    @mom = Mom.find(params[:mom_id])
    @kid = @mom.kids.find(params[:id])
    @kid.destroy
    redirect_to mom_path(@mom)
  end</pre>

10. Add the following lines to `app/views/moms/show.html.erb` before the line
containing `<%= link_to 'Edit', edit_mom_path(@mom) %> |`

<pre>&lt;h2>Kids&lt;/h2>
&lt;%= render :partial => "kids/kid", :collection => @mom.kids %>

&lt;h3>Add kid&lt;/h3>
&lt;%= render 'kids/form' %></pre>

11. Create a file `app/views/kids/_kid.html.erb` with the following code:

<pre>&lt;p>
  &lt;strong>Kid:&lt;/strong>
  &lt;%= kid.name %>
  &lt;%= link_to 'Remove', [kid.mom, kid], :confirm => 'Really remove kid?', :method => :delete %>
&lt;/p></pre>

12. Create a file `app/views/kids/_form.html.erb` with the following code:

<pre>&lt;%= form_for([@mom, @mom.kids.build]) do |f| %>
  &lt;div class="field">
    &lt;%= f.label :name %> &lt;%= f.text_field :name %>
  &lt;/div>

  &lt;div class="actions">
    &lt;%= f.submit %>
  &lt;/div>
&lt;% end %></pre>

13. `rails s`

14. Point your browser to `http://localhost:3000/moms`.
