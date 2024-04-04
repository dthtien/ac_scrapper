# frozen-string-literal: true
require 'rails_helper'

describe Scrapers::AirConditionersScraper do
  let(:service) { Scrapers::AirConditionersScraper.new }

  describe '#call' do
    let(:response) do
      <<-HTML
      <!DOCTYPE html>
      <html lang="en-AjU" >
      <body>
      <div id="mk-login-panel">
      <form id="mk_login_form" name="mk_login_form" method="post" class="mk-login-form" action="https://www.airwaresales.com.au/wp-login.php">
      <span class="form-section">
      <label for="log">Email Address / Username</label>
      <input type="text" id="username" name="log" class="text-input">
      </span>
      <span class="form-section">
      <label for="pwd">Password</label>
      <input type="password" id="password" name="pwd" class="text-input">
      </span>
      <label class="mk-login-remember">
      <input type="checkbox" name="rememberme" id="rememberme" value="forever"> Remember Me					</label>

      <input type="submit" id="login" name="submit_button" class="accent-bg-color button" value="LOG IN">
      <input type="hidden" id="security" name="security" value="7867e16409" /><input type="hidden" name="_wp_http_referer" value="/" />
      <div class="register-login-links">
      <a href="#" class="mk-forget-password">Forgot?</a>
      </div>
      <div class="clearboth"></div>
      <p class="mk-login-status"></p>
      </form>
      </div>
      <div class="product">
      <div class="astra-shop-thumbnail-wrap"><a href="https://www.airwaresales.com.au/product/kelvinator-kwh39hrf-3-9kw-reverse-cycle/" class="woocommerce-LoopProduct-link woocommerce-loop-product__link"><img width="300" height="300" src="https://www.airwaresales.com.au/wp-content/uploads/2017/08/kelvinator-reverse-cycle-wall-unit-300x300.jpg" class="attachment-woocommerce_thumbnail size-woocommerce_thumbnail" alt="" decoding="async" srcset="https://www.airwaresales.com.au/wp-content/uploads/2017/08/kelvinator-reverse-cycle-wall-unit-300x300.jpg 300w, https://www.airwaresales.com.au/wp-content/uploads/2017/08/kelvinator-reverse-cycle-wall-unit-1024x1024.jpg 1024w, https://www.airwaresales.com.au/wp-content/uploads/2017/08/kelvinator-reverse-cycle-wall-unit-225x225.jpg 225w, https://www.airwaresales.com.au/wp-content/uploads/2017/08/kelvinator-reverse-cycle-wall-unit-768x768.jpg 768w, https://www.airwaresales.com.au/wp-content/uploads/2017/08/kelvinator-reverse-cycle-wall-unit-500x500.jpg 500w, https://www.airwaresales.com.au/wp-content/uploads/2017/08/kelvinator-reverse-cycle-wall-unit-100x100.jpg 100w, https://www.airwaresales.com.au/wp-content/uploads/2017/08/kelvinator-reverse-cycle-wall-unit.jpg 1200w" sizes="(max-width: 300px) 100vw, 300px"></a></div>
      <span class="gtm4wp_productdata" style="display:none; visibility:hidden;" data-gtm4wp_product_data='{"internal_id":2228,"item_id":2228,"item_name":"Kelvinator KWH39HRF (3.9kW) Reverse Cycle","sku":"KWH39HRF","price":819,"stocklevel":null,"stockstatus":"instock","google_business_vertical":"retail","item_category":"Window Air Conditioners","id":2228,"productlink":"https:\/\/www.airwaresales.com.au\/product\/kelvinator-kwh39hrf-3-9kw-reverse-cycle\/","item_list_name":"General Product List","index":1,"item_brand":""}'></span><div class="astra-shop-summary-wrap">                   <span class="ast-woo-product-category">
      Window Air Conditioners                 </span>
      <a href="https://www.airwaresales.com.au/product/kelvinator-kwh39hrf-3-9kw-reverse-cycle/" class="ast-loop-product__link"><h2 class="woocommerce-loop-product__title">Kelvinator KSD39HRF (3.9kW) Reverse Cycle</h2></a><div class="label-wrap itwapl-none label-blue itwapl-alignnone itwapl-shape-circle  label-wrap-8548">
      <span class="woocommerce-advanced-product-label product-label label-blue">
      </span>
      </div>
      <script type="text/javascript">
      jQuery("head").append( "<style>.label-wrap.label-wrap-8548{top:; right:; }</style>" );
      </script>
      <span class="price"><span class="woocommerce-Price-amount amount"><bdi><span class="woocommerce-Price-currencySymbol">$</span>819.00</bdi></span></span>
      <a href="?add-to-cart=2228" data-quantity="1" class="button product_type_simple add_to_cart_button ajax_add_to_cart " data-product_id="2228" data-product_sku="KWH39HRF" aria-label="Add to cart: “Kelvinator KWH39HRF (3.9kW) Reverse Cycle”" aria-describedby="" rel="nofollow">Add to cart</a>
      </div>
      </div>
      </body>
      </html>
      HTML
    end
    let!(:item) { create(:item) }
    let(:adapter_double) do
      instance_double(
        AirWareSalesAdapter,
        login: nil,
        get_items: Nokogiri::HTML(response)
      )
    end

    before do
      allow(AirWareSalesAdapter).to receive(:new).and_return(adapter_double)
      service.call
    end

    it do
      expect(adapter_double).to have_received(:login)
      expect(adapter_double).to have_received(:get_items).with(
        AirWareSalesAdapter::BRAND_URLS[0]
      )
      expect(adapter_double).to have_received(:get_items).with(
        AirWareSalesAdapter::BRAND_URLS[1]
      )
      expect(adapter_double).to have_received(:get_items).with(
        AirWareSalesAdapter::BRAND_URLS[2]
      )
      expect(adapter_double).to have_received(:get_items).with(
        AirWareSalesAdapter::BRAND_URLS[3]
      )
      expect { item.reload }.to raise_error ActiveRecord::RecordNotFound
      expect(Item.exists?).to be_truthy
    end
  end
end
