module ApplicationHelper
  def self.sanitize_pci(log)
    CreditCardSanitizer.new().sanitize!(log.to_s) || log
  end

  def currency_to_number(currency)
    currency.to_s.gsub(/[$,]/,'').to_f
  end

  def money_decorated(amount)
    "R$#{number_with_precision(amount.to_f/100, precision: 2, separator: ',', delimiter: '.', significant: false)}"
  end

  def percent_decorated(amount)
    "#{number_with_precision(amount.to_f/100, precision: 2, separator: ',', delimiter: '.', significant: false)}%"
  end

  def cc_years
    yrs = []
    year_today = Date.today.strftime("%Y").to_i
    year_today.upto(year_today+10).each do |y| yrs << y.to_s;end
    return yrs
  end

  def cc_months
    ['01','02','03','04','05','06','07','08','09','10','11','12']
  end

  def cc_brands
    ['VISA','MASTER','ELO','AMEX','DINERS']
  end

  def devise_anser_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation" class="alert alert-warning" >
      <!--<h2>#{sentence}</h2>-->
      <ul style="font-size: 14px;">#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
