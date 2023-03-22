class ExpensesController < ApplicationController
  def new
    @expense = Expense.new
  end

  def create
    @group = Group.find(params[:group_id])
    @expense = Expense.new(expense_params)
    @expense.user = current_user

    if @expense.save
      flash[:notice] = 'Expense created successfully'
      redirect_to @group
    else
      flash[:alert] = @expense.errors.full_messages.first if @expense.errors.any?
      render :new, status: :unprocessable_entity
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, group_ids: [])
  end
end