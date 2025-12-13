module Admin
  class LabelsController < BaseController
    before_action :set_label, only: %i[edit update destroy]
    def index
      @labels = Label.order(created_at: :asc)
      @pagy, @labels = pagy(@labels, limit: 5)
    end

    def new
      @label = Label.new
    end

    def edit; end

    def create
      @label = Label.new(label_params)
      if @label.save
        flash[:success] = "ラベルが作成されました"
        redirect_to admin_labels_path, status: :see_other
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      if @label.update(label_params)
        flash[:success] = "ラベルが更新されました"
        redirect_to admin_labels_path, status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      if @label.destroy
        flash[:success] = "ラベルが削除されました"
        redirect_to admin_labels_path, status: :see_other
      else
        flash.now[:error] = "ラベルの削除に失敗しました"
        render :index, status: :unprocessable_content
      end
    end

    private

    def set_label
      @label = Label.find(params[:id])
    end

    def label_params
      params.require(:label).permit(:name)
    end
  end
end
