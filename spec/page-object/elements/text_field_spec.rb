require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TextField do

  describe "when mapping how to find an element" do
    let(:textfield) { PageObject::Elements::TextField }

    it "should map watir types to same" do
      [:class, :id, :index, :name, :tag_name, :title, :xpath].each do |t|
        identifier = textfield.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to watir" do
      identifier = textfield.watir_identifier_for :css => 'value'
      identifier.keys.first.should == :tag_name
    end

    it "should map selenium types to same" do
      [:class, :css, :id, :name, :title, :xpath, :index].each do |t|
        key, value = textfield.selenium_identifier_for t => 'value'
        key.should == t
      end
    end

    it "should map watir types to selenium" do
      key, value = textfield.selenium_identifier_for :tag_name => 'value'
      key.should == :css
    end
  end
  
  describe "interface" do
    it "should register with type :text" do
      ::PageObject::Elements.element_class_for(:input, :text).should == ::PageObject::Elements::TextField
    end

    it "should register with type :password" do
      ::PageObject::Elements.element_class_for(:input, :password).should == ::PageObject::Elements::TextField
    end
    
    context "for selenium" do
      it "should set its' value" do
        text_field_element = double('selenium_text_field')
        selenium_text_field = PageObject::Elements::TextField.new(text_field_element, :platform => :selenium_webdriver)
        text_field_element.should_receive(:clear)
        text_field_element.should_receive(:send_keys).with('Joseph')
        selenium_text_field.value = 'Joseph'
      end
    end
  end
end
