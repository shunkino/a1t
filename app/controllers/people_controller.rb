class PeopleController < ApplicationController
  protect_from_forgery :except => [:refresh]
	before_action :set_person, only: [:edit, :update, :destroy]
	# 新規ユーザー
  def new 
		@person = Person.new
  end

	# ユーザーを作成する Post
	# CAPTCHA入れたほうがいいね(スパム防止)
	def create 
		@person = Person.new(person_new)
		respond_to do |format|
			if @person.save
				format.html { redirect_to places_path, notice: 'People was successfully created.' }
				format.json { render :show, status: :created, location: @person }
			else
				format.html { render :new }
				format.json { render json: @person.errors, status: :unprocessable_entity }
			end
		end
	end

	# ユーザーの情報を編集する
	# @personに暗黙的にidを元に参照されたインスタンスが挿入される
  def edit
  end
	
	# ユーザーの情報を更新する Post
	def update 
		respond_to do |format|
			if @person && @person.authenticate(params[:person][:password])
				if @person.update(person_new)
					format.html { redirect_to places_path, notice: 'Person was successfully updated.' }
					format.json { render :show, status: :ok, location: @person }
				else
					format.html { redirect_to edit_person_path, notice: '更新に失敗しました。' }
					format.json { render json: @person.errors, status: :unprocessable_entity }
				end
			# passwordが間違っていた時
			else 
				format.html { redirect_to edit_person_path, notice: 'パスワードが間違っています。' }
				format.json { render json: @person.errors, status: :unprocessable_entity }
			end	
		end
	end

	# ビーコン情報の変化
	def refresh
		puts "this is a test" + params[:placeUUID]
		puts "hogehogeho " + params[:password]
		# @person = Person.new(person_refresh)
		@person = Person.find_by twitter: params[:twitter]
		puts params[:twitter] 
		# パスワードが正しければ,uuidからplace idを計算して情報を更新
		if @person && @person.authenticate(params[:password])
			place = Place.find_by beaconUUID: params[:placeUUID]
			if @person.update(place_id: place.id)				
				render :json => {"Success" => "データを書き込みました"}
			else
				render :json => {"Error" => "Update失敗です"}
			end
		else
			# パスワードが間違っている
			render :json => {"Error" => "パスワードが間違っています"}
		end
	end

	# ユーザーを削除する Post
  def destroy 
		respond_to do |format|
			if @person && @person.authenticate(params[:person][:password])
				if @person.destroy
					format.html { redirect_to places_url, notice: 'People was successfully destroyed.' }
					format.json { head :no_content }
				else
					format.html { redirect_to places_url, notice: 'People was not destroyed.' }
					format.json { render json: @person.errors, status: :unprocessable_entity }
				end
			# passwordが間違っていた時
			else 
				format.html { redirect_to places_url, notice: 'パスワードが間違っています。' }
				format.json { render json: @person.errors, status: :unprocessable_entity }
			end	
		end

    respond_to do |format|
          end
  end
	
	private
		def set_person
			@person = Person.find(params[:id])
		end

	# 新規にユーザを作成する時
    def person_new
      params.require(:person).permit(:personName, :twitter, :password, :password_confirmation)
    end
	# 場所が変化する時だけ
    def person_refresh
      params.require(:person).permit(:personName, :twitter, :password, :password_confirmation, :placeUUID)
    end

end
