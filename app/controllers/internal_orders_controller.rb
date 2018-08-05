class InternalOrdersController < ApplicationController
  before_action :set_internal_order, only: [:show, :edit, :update, :destroy, :delete, :deliver]

  # GET /internal_orders
  # GET /internal_orders.json
  def index
    @filterrific = initialize_filterrific(
      InternalOrder,
      params[:filterrific],
      select_options: {
        sorted_by: InternalOrder.options_for_sorted_by
      },
      persistence_id: false,
      default_filter_params: {sorted_by: 'created_at_desc'},
      available_filters: [
        :sorted_by,
        :search_query,
        :date_received_at,
      ],
    ) or return
    @internal_orders = @filterrific.find.page(params[:page]).per_page(8)

    @internal_orders = @internal_orders.with_sector_id(current_user.sector_id)


    respond_to do |format|
      format.html
      format.js
    end
    rescue ActiveRecord::RecordNotFound => e
      # There is an issue with the persisted param_set. Reset it.
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /internal_orders/1
  # GET /internal_orders/1.json
  def show
    respond_to do |format|
      format.js
    end
  end

  # GET /internal_orders/new
  def new
    @internal_order = InternalOrder.new
    @responsables = User.all
    @supplies = SupplyLot.all
    @internal_order.quantity_supply_lots.build
  end

  # GET /internal_orders/1/edit
  def edit
    @responsables = User.all
    @supplies = SupplyLot.all
  end

  # POST /internal_orders
  # POST /internal_orders.json
  def create
    @internal_order = InternalOrder.new(internal_order_params)

    respond_to do |format|
      if @internal_order.save!
        # Si se carga y entrega el pedido
        if delivering?
          begin
            @internal_order.deliver
            flash.now[:success] = "El pedido interno de "+@internal_order.responsable.sector.sector_name+" se ha creado y entregado correctamente."
          rescue ArgumentError => e
            flash.now[:notice] = "Se ha creado pero no se ha podido entregar: "+e.message
          end
        else
          flash.now[:success] = "El pedido interno de "+@internal_order.responsable.sector.sector_name+" se ha creado correctamente."
        end
        format.js
      else
        flash.now[:error] = "El pedido interno no se ha podido crear."
        format.js
      end
    end
  end

  # PATCH/PUT /internal_orders/1
  # PATCH/PUT /internal_orders/1.json
  def update
    respond_to do |format|
      if @internal_order.update_attributes(internal_order_params)
        # Si se carga y entrega el pedido
        if delivering?
          begin
            @internal_order.deliver
            flash.now[:success] = "El pedido interno de "+@internal_order.responsable.sector.sector_name+" se ha modificado y entregado correctamente."
          rescue ArgumentError => e
            flash.now[:notice] = "Se ha modificado pero no se ha podido entregar: "+e.message
          end
        else
          flash.now[:success] = "El pedido interno de "+@internal_order.responsable.sector.sector_name+" se ha modificado correctamente."
        end
        format.js
      else
        flash.now[:error] = "El pedido interno de "+@internal_order.responsable.sector.sector_name+" no se ha podido modificar."
        format.js
      end
    end
  end

  # DELETE /internal_orders/1
  # DELETE /internal_orders/1.json
  def destroy
    @sector_name = @internal_order.responsable.sector.sector_name
    @internal_order.destroy
    respond_to do |format|
      flash.now[:success] = "El pedido interno de "+@sector_name+" se ha eliminado correctamente."
      format.js
    end
  end

  # GET /internal_order/1/delete
  def delete
    respond_to do |format|
      format.js
    end
  end

  # GET /internal_orders/1/dispense
  def deliver
    respond_to do |format|
      begin
        @internal_order.deliver

      rescue ArgumentError => e
        flash.now[:error] = e.message
        format.js
      else
        if @internal_order.save!
          flash.now[:success] = "El pedido interno de "+@internal_order.responsable.full_name+" se ha entregado correctamente."
          format.js
        else
          flash.now[:error] = "El pedido interno no se ha podido entregar."
          format.js
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internal_order
      @internal_order = InternalOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def internal_order_params
      params.require(:internal_order).permit(:responsable_id, :date_delivered, :date_received, :observation,
        quantity_supply_lots_attributes: [:id, :supply_lot_id, :quantity, :_destroy])
    end

    # Se verifica si el value del submit del form es para dispensar
    def delivering?
      submit = params[:commit]
      return submit == "Cargar y entregar" || submit == "Guardar y entregar"
    end
end
