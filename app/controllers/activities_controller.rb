# A tarefinha é nesse arquivo
class ActivitiesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        # listar as atividades (variável activities)
        @activities = Activity.all

        # criar uma atividade (variável activity)
        @activity = Activity.new
    end
    
    def create
        #Crie uma atividade aqui
        @activity = Activity.new(activity_params)

        @activity.save

        #Envie uma mensagem com flash[:msg] contendo o alerta
        @alert = "Atividade criada"
        flash[:msg] = @alert

        write_alert_on_log
        redirect_to activities_index_url
    end

    def destroy
        #Destrua uma atividade por id
        @activity = Activity.find(params[:id])
        @activity.destroy

        #Envie uma mensagem com flash[:msg] contendo o alerta
        @alert = "Atividade destruída"
        flash[:msg] = @alert

        write_alert_on_log
        redirect_to activities_index_url
    end

    private

    def activity_params
        #Defina os parâmetros de cada atividade em params
        params.require(:activity).permit(:name, :date, :description)
    end

    def write_alert_on_log
        #Apenas para debug, ignorem isso
        Rails.logger.debug "--------------------------------------"
        Rails.logger.debug "Mensagem de alerta: " + @alert
        Rails.logger.debug "--------------------------------------"
    end
end
