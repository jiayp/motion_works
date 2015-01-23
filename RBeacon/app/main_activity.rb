class MainActivity < Android::App::Activity
  attr_accessor :info, :tx_power, :rssi
  def onCreate(savedInstanceState)
    super


    layout = Android::Widget::LinearLayout.new(self)
    layout.orientation = Android::Widget::LinearLayout::VERTICAL
    @bludetooth = Android::Bluetooth::BluetoothAdapter.getDefaultAdapter

    @rssi = new_text_label
    @tx_power = new_text_label
    @info = new_text_label

    layout.addView(@info)
    layout.addView(@tx_power)
    layout.addView(@rssi)


    button = Android::Widget::Button.new(self)
    button.text = '开始'
    button.onClickListener = self
    layout.addView(button)

    self.contentView = layout

    # Create and connect the broadcast receiver.
    @update_receiver = BeaconReceiver.new
    @update_receiver.delegate = self
    intent_filter = Android::Content::IntentFilter.new(BeaconReceiver::Message)
    intent_filter.addAction('android.bluetooth.adapter.action.DISCOVERY_STARTED')
    intent_filter.addAction('android.bluetooth.adapter.action.DISCOVERY_FINISHED')
    registerReceiver(@update_receiver, intent_filter)    
  end

  def onClick(view)
    @info.text = @bludetooth.startDiscovery.to_s
  end    

  def new_text_label
    text = Android::Widget::TextView.new(self)
    text.textColor = Android::Graphics::Color::WHITE
    text.gravity = Android::View::Gravity::CENTER_HORIZONTAL
    text.textSize = 40.0
    text
  end  
end

class BeaconReceiver < Android::Content::BroadcastReceiver
  Message = "android.bluetooth.device.action.FOUND" 
  attr_accessor :delegate

  def onReceive(content, intent)
    msg = intent.getStringExtra('msg')
    content.tx_power.text = intent.data
    if intent.extras
      puts intent.extras.toString
    else
      puts 'nil'
    end
    content.info.text = intent.action.to_s+msg.to_s
  end
end
