class TaskSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes # 型を持つattributes(カラム的なもの)をかんたんに定義

  attribute :title, :string
  attribute :status, :string
  attribute :order, :string

  # 検索処理の本体
  def search
    tasks = Task.all

    # ▼ タイトル検索
    tasks = tasks.where("title LIKE '%#{title}%'") if title.present?

    # ▼ ステータス検索
    tasks = tasks.where(status: status) if status.present? && Task.statuses.keys.include?(status)

    # ▼ ソート
    case order
    when "latest"  then tasks.latest
    when "created" then tasks.created
    else tasks.updated
    end
    tasks
  end
end
