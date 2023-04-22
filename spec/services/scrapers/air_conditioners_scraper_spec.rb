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
      <div class="item">
      <div class="mk-shop-item-detail">


      <h3 class="product-title"><a href="https://www.airwaresales.com.au/product/lg-ws18tws/">LG SRKWS18TWS</a></h3>

      4.8kW(C)/5.9kW(H)
      <div class="pwb-brands-in-loop"><span><a href="https://www.airwaresales.com.au/brand/air-conditioners/lg/">LG Air Conditioners</a></span></div>
      <span class="price"><del aria-hidden="true"><span class="woocommerce-Price-amount amount"><bdi><span class="woocommerce-Price-currencySymbol">&#36;</span>1,269.00</bdi></span></del> <ins><span class="woocommerce-Price-amount amount"><bdi><span class="woocommerce-Price-currencySymbol">&#36;</span>1,199.00</bdi></span></ins> <small class="woocommerce-price-suffix">inc GST</small></span>

        <div class="product-item-footer without-rating">
      </a><a rel="nofollow" href="?add-to-cart=8561" data-quantity="1" data-product_id="8561" data-product_sku="191-1-2-2-1-1" class="product_loop_button product_type_simple add_to_cart_button ajax_add_to_cart" data-product_id="8561" data-product_sku="191-1-2-2-1-1" aria-label="Add &ldquo;LG WS18TWS&rdquo; to your cart" rel="nofollow"><svg  class="mk-svg-icon" data-name="mk-moon-cart-plus" data-cacheid="icon-64434834635bb" style=" height:16px; width: 16px; "  xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M416 96h-272c-16.138 0-29.751 12.018-31.753 28.031l-28.496 227.969h-51.751c-17.673 0-32 14.327-32 32s14.327 32 32 32h80c16.138 0 29.751-12.017 31.753-28.031l28.496-227.969h219.613l57.369 200.791c4.854 16.993 22.567 26.832 39.56 21.978 16.993-4.855 26.833-22.567 21.978-39.56l-64-224c-3.925-13.737-16.482-23.209-30.769-23.209zm-288-80a48 48 2700 1 0 96 0 48 48 2700 1 0-96 0zm192 0a48 48 2700 1 0 96 0 48 48 2700 1 0-96 0zm64 240h-64v-64h-64v64h-64v64h64v64h64v-64h64z" transform="scale(1 -1) translate(0 -480)"/></svg><span class="product_loop_button_text">Add to Order</a>	</div>


      </div>
      </div>
      </article>

      <article class="item mk--col mk--col--3-12 post-7752 product type-product status-publish has-post-thumbnail pwb-brand-kelvinator product_cat-hi-wall-split-airconditioners product_tag-5kw product_tag-inverter product_tag-kelvinator product_tag-reverse-cycle product_tag-split-system product_shipping_class-store-pickup last instock sale featured taxable shipping-taxable purchasable product-type-simple">
      <div class="mk-product-holder">
      <div class="product-loop-thumb">
      <span class="onsale">Sale</span><a href="https://www.airwaresales.com.au/product/kelvinator-ksd50hwj/" class="product-link"><img src="https://www.airwaresales.com.au/wp-content/uploads/bfi_thumb/dummy-transparent-nifek5r08hhc7i39jyp4kzv6dtn3bscia2cx80opw0.png" data-mk-image-src-set='{"default":"https://www.airwaresales.com.au/wp-content/uploads/bfi_thumb/kelvinator-ksv-models-ocbwsu14smbcxmzmtvsdqi0n5mhs4qe23b1ku2ayvk.jpg","2x":"https://www.airwaresales.com.au/wp-content/uploads/bfi_thumb/kelvinator-ksv-models-ocbwsu189lupmui4q4dmia9gs9tcq8dcngg5n1mbs0.jpg","mobile":"","responsive":"true"}' class="product-loop-image" alt="Kelvinator KSD50HWJ" title="Kelvinator KSD50HWJ" itemprop="image" /><span class="product-loading-icon added-cart"></span></a>
      <div class="label-wrap itwapl-none label-black itwapl-alignnone itwapl-shape-circle  label-wrap-7800">
      <span class="woocommerce-advanced-product-label product-label label-black" >
      Offer available in QLD & VIC Only                </span>
      </div>
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
