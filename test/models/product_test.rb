require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  fixtures :products

  test "product attributes must not be empty" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:image_url].any?
  	assert product.errors[:price].any?
  end

  test "product price must be positive" do
  	product = Product.new(title: "Hi1234567890", description: "blablabla", image_url: "img.jpg")
  	
  	product.price = -1
  	assert product.invalid?
  	assert_equal "must be greater than or equal to 0.01", product.errors[:price].join(';')

  	product.price = 0
  	assert product.invalid?
  	assert_equal "must be greater than or equal to 0.01", product.errors[:price].join(';')

  	product.price = 1
  	assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: "Hi0123456789", description: "blablabla", price: 0.01, image_url: image_url)
  end

  test "image url must end in .jpg, .gif or .png" do

    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      product = new_product(name)
      assert product.valid?, "#{name} shouldn't be invalid, #{product.errors.full_messages}"
    end
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end

  end

  test "product is not valid without unique title" do
    product = Product.new(title: products(:ruby).title, description: "blablabla", price: 0.01, image_url: "img.jpg")
    assert !product.save
    assert_equal "has already been taken", product.errors[:title].join("; ")
  end

  test "title name is at least 10 characters long" do
    product = Product.new(title: "12345678901", description: "blablabla", price: 0.01, image_url: "img.jpg")
    assert product.valid?, "title too short" 
  end

end
