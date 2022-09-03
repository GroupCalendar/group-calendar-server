class GroupsController < ApplicationController

  def show
    @group = Group.find_by_id(params[:id])
  end

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(create_group_params)
    if @group
      Membership.create({ user: current_user, group: @group })
    end
    redirect_to '/groups', notice: "Created"
  end

  def search
    if params[:query]
      # TODO also return joined groups
      @groups = Group.where("name ilike ?", "%#{params[:query]}%")
                     .where("visibility_type = ?", 0)
    end
  end

  def join
    if params[:id]
      @group = Group.find_by_id(params[:id])
      if @group
        Membership.create({ user: current_user, group: @group, access_level: 'member' })
      end
      redirect_to '/groups', notice: "Joined"
    end
  end

  def leave
    if params[:id]
      @group = Group.find_by_id(params[:id])
      if @group
        Membership.destroy_by({ user: current_user, group: @group })
      end
      redirect_to '/groups', notice: "Left"
    end
  end

  private

  def create_group_params
    params.require(:group).permit(:name, :visibility_type, :join_type, :passcode)
  end
end
