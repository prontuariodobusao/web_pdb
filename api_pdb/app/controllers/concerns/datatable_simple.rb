module DatatableSimple
  extend ActiveSupport::Concern

  def datatable_render(resources, params, field_search:)
    if params[:sort_field].present?
      sort_hash = {}
      sort_hash[params[:sort_field].to_sym] = params[:sort_direction].to_sym
      resources = resources.order(sort_hash)
    end
    if params[:search_value].present?
      search = "%#{params[:search_value]}%"
      resources = resources.where("#{field_search} ILIKE ?", search)
    end
    total = resources.count

    resources = resources.page(params[:page]).per_page(params[:per_page])

    { totalRecords: total, result: resources }
  end
end
