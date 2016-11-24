class AgentController < ApplicationController
  def index
    @agents = Agent.all
    send_data(@agents.to_xls)
  end
end
