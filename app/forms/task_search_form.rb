class TaskSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes # 型を持つattributes(カラム的なもの)をかんたんに定義

  # Rails の params はすべて文字列で来る
  attribute :title, :string
  attribute :status, :string
  attribute :priority, :string
  attribute :order, :string

  # 検索処理の本体
  def search
    tasks = Task.all
    tasks = filter_title(tasks)
    tasks = filter_status(tasks)
    tasks = filter_priority(tasks)
    sort_order(tasks)
  end

  private

  # ▼ タイトル検索
  def filter_title(tasks)
    title.present? ? tasks.where("title LIKE '%#{title}%'") : tasks
  end

  # ▼ ステータス検索
  def filter_status(tasks)
    status.present? && Task.statuses.keys.include?(status) ? tasks.where(status: status) : tasks
  end

  # ▼ 優先度検索
  def filter_priority(tasks)
    priority.present? && Task.priorities.keys.include?(priority) ? tasks.where(priority: priority) : tasks
  end

  # ▼ ソート
  def sort_order(tasks)
    case order
    when "latest"
      tasks.latest
    when "created"
      tasks.created
    else
      tasks.updated
    end
  end
end
