class DnsRecordsController < ApplicationController
  before_action :get_zone

  # POST /dns_records
  # POST /dns_records.json
  def create
    @dns_record = @zone.dns_records.build(dns_record_params)
    @dns_record.ttl = (30 * 60) if @dns_record.ttl.nil?
    respond_to do |format|
      if @dns_record.save
        format.html { redirect_to zone_path(@zone), notice: 'DNS Record was successfully created.' }
        format.json { render :show, status: :created, location: @zone }
      else
        puts "failed to save DNS record: #{@dns_record.errors.to_json}"
        format.html { render 'zones/show' }
        format.json { render json: @dns_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dns_records/1
  # PATCH/PUT /dns_records/1.json
  def update
    @dns_record = @zone.dns_records.find_by(id: params[:id])
    respond_to do |format|
      if @dns_record.update(dns_record_params)
        format.html { redirect_to zone_path(@zone), notice: 'DNS Record was successfully updated.' }
        format.json { render :show, status: :ok, location: @zone }
      else
        format.html { render :edit }
        format.json { render json: @dns_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dns_records/1
  # DELETE /dns_records/1.json
  def destroy
    @dns_record = @zone.dns_records.find_by(id: params[:id])
    @dns_record.destroy
    respond_to do |format|
      format.html { redirect_to zone_path(@zone), notice: 'DNS Record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def get_zone
   @zone = Zone.find_by(name: params[:zone_name])
  end

  def dns_record_params
    p = params.require(:dns_record).permit(:record_type, :name, :value, :ttl, :zone_id)
    p[:record_type] = DnsRecord.record_types[params[:dns_record][:record_type]]
    p
  end
end
