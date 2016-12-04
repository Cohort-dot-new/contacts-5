class ContactsController < ApplicationController
  def index
    if current_user
      @contacts = current_user.contacts
      render 'index.html.erb'
    else
      flash[:warning] = 'You must be logged in to see this page!'
      redirect_to '/login'
    end
  end

  def show
    @contact = Contact.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def new
    @contact = Contact.new
    render 'new.html.erb'
  end

  def create
    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone: params[:phone],
      user_id: current_user.id
    )
    if @contact.save
      flash[:success] = "Contact created."
      redirect_to "/contacts/#{@contact.id}"
    else
      render 'new.html.erb'
    end
  end

  def edit
    @contact = Contact.find_by(id: params[:id])
    render 'edit.html.erb'
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.phone = params[:phone]
    if @contact.save
      flash[:success] = "Contact updated."
      redirect_to "/contacts/#{@contact.id}"
    else
      render 'edit.html.erb'
    end
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    flash[:success] = "Contact deleted."
    redirect_to "/"
  end

  def index_johns
    @contacts = Contact.all_johns
    render 'index.html.erb'
  end
end
