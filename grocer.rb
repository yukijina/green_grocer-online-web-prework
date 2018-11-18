
def consolidate_cart(cart)
  # code here
  hash = {}
  cart.each do |to_hash|
    to_hash.each do |item, data_hash|
      if hash[item].nil?
         hash[item] = data_hash.merge({:count => 1})
      else 
        hash[item][:count] += 1
      end
    end
  end
    hash   
end


def apply_coupons(cart, coupons)
  hash = cart
  coupons.each do |coupon_hash|
    
    item = coupon_hash[:item]

    if !hash[item].nil? && hash[item][:count] >= coupon_hash[:num]
      add = {"#{item} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => hash[item][:clearance],
        :count => 1
        }
      }
      
      if hash["#{item} W/COUPON"].nil?
        hash.merge!(add)
      else
        hash["#{item} W/COUPON"][:count] += 1
      end
      
      hash[item][:count] -= coupon_hash[:num]
    end
  end
  hash
end



def apply_clearance(cart)
  # code here
  hash = cart
  cart.each do |item, data|
    if cart[item][:clearance] == true 
      discount_price = (cart[item][:price] * 0.80).round(2)
      cart[item][:price] = discount_price
    end
  end
end

def checkout(cart, coupons)
  # code here
  consolidated = consolidate_cart(cart)
  applied_coupon = apply_coupons(consolidated, coupons)
  applied_clearance = apply_clearance(applied_coupon)
  
  array = []
  applied_clearance.each do |item, data|
    array << applied_clearance[item][:price] * applied_clearance[item][:count]
  end
  sum = array.inject(0){|sum,x| sum + x}
  sum >=100? (sum*0.9).round(2): sum.round(2)
  
end
