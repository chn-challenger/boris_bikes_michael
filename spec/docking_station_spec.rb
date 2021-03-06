
require "docking_station"

describe DockingStation do
	it { is_expected.to respond_to (:release_bike) }


	it 'releases working bikes' do
		subject.dock Bike.new
		bike = subject.release_bike
		expect(bike).to be_working
	end

	it { is_expected.to respond_to(:dock).with(1).argument }

	describe '#release_bike' do
		it 'raises an error when there are no bikes available' do
			expect { subject.release_bike }.to raise_error 'No bikes available'
		end
		it 'raises an error when there is only one broken bike available' do
			bike_new = Bike.new
			bike_new.report_broken
			subject.dock bike_new
			expect{subject.release_bike}.to raise_error 'No bikes available'
		end
	end

	describe '#dock' do
		it 'raises an error when full' do
			station1 = DockingStation.new
			station1.capacity.times{station1.dock(Bike.new)}
			expect{ station1.dock Bike.new }.to raise_error 'Docking station full'
		end
	end

	it do
		station = DockingStation.new
		expect(station.capacity).to eq DockingStation::DEFAULT_CAPACITY
	end

	it do
		expect(subject).to respond_to(:capacity=).with(1).argument
	end


end 

