class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    # 曜日の配列を用意
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    #配列を用意
    @week_days = []
    #今日から7日分の予定を@plansに代入。
    #viewと繰り返し処理で使う。
    @plans = Plan.where(date: @todays_date..@todays_date + 7)

    7.times do |x|
      plans = []
      plan = @plans.map do |plan|
        plans.push(plan.plan) if plan.date == @todays_date + x
      end
      day = {month: (@todays_date + x).month, date: (@todays_date + x).day, wday: wdays[(@todays_date + x).wday],plan: plans, }
      @week_days.push(day)
    end
  end
end
    # 7日分作るようにする
    # |x|が0-6回分繰り返される
    # plansという配列を作り、繰り返した作業１つずつ入れて行く
    #もし予定日が今日+x日ならば、plans配列にplanの予定をいれる
    # ☆以下をdayに代入
        #month:「今日の日付＋x(0-6日)」の月
        #date:「今日の日付+x(0-6日)」の日
        #wday:「今日の日付+x(0-6日)」の曜日
        #plan:plansに代入されたもの
    # dayをweekdaysに代入し、出力。