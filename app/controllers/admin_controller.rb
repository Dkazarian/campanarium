class AdminController < ApplicationController
  authorize_resource
  
  def board
  end

  def async_response
    semantic_task = AsyncTask.find_by_id(session[:semantic_task_id])
    session.delete(:semantic_task_id) if semantic_task.nil? || semantic_task.stopped?
    sentiments_task = AsyncTask.find_by_id(session[:sentiments_task_id])
    session.delete(:sentiments_task_id) if sentiments_task.nil? || sentiments_task.stopped?
    render json: { status: 200, semantic_status: semantic_task.try(:status), sentiments_status: sentiments_task.try(:status)}
  end

  def load_comments
    count = NoticeGroupCommentsLoader.perform
    render json: { status: 200, task_status: count > 0 ? "ok" : "stopped"}
  end

  def load_notices
    begin
      to = Time.zone.now
      from = to - params["hours"].to_i.hours
      notices_q = Notice.count
      NoticesLoader.perform(from, to)
      notices_q = Notice.count - notices_q
      render json: {status: 200, task_status: "ok", message: "#{notices_q} noticias nuevas."}
    rescue => e
      render json: {status: 500, task_status: "failure", message: "Hubo un error cargando las noticias."}
      throw e
    end
  end
end