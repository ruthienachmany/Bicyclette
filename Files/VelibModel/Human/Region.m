#import "Region.h"

/****************************************************************************/
#pragma mark -

@interface Region ()
@property (readonly, nonatomic, readwrite) MKCoordinateRegion coordinateRegion;
@end

/****************************************************************************/
#pragma mark -

@implementation Region

@synthesize coordinateRegion;

- (void) setupCoordinates
{
	self.minLatitude = [self.stations valueForKeyPath:@"@min.latitude"];
	self.maxLatitude = [self.stations valueForKeyPath:@"@max.latitude"];
	self.minLongitude = [self.stations valueForKeyPath:@"@min.longitude"];
	self.maxLongitude = [self.stations valueForKeyPath:@"@max.longitude"];
}

- (NSString *) debugDescription
{
	return [NSString stringWithFormat:@"Region %@ (%@) - %d stations - de {%f,%f} à {%f,%f}",
			self.number, self.name,
			self.stations.count,
			self.minLatitudeValue, self.minLongitudeValue, self.maxLatitudeValue, self.maxLongitudeValue];
}

- (MKCoordinateRegion) coordinateRegion
{
	if(coordinateRegion.center.latitude == 0 &&
	   coordinateRegion.center.longitude == 0 &&
	   coordinateRegion.span.latitudeDelta == 0 &&
	   coordinateRegion.span.longitudeDelta == 0 )
	{
		CLLocationCoordinate2D center;
		center.latitude = (self.minLatitudeValue + self.maxLatitudeValue) / 2.0f;
		center.longitude = (self.minLongitudeValue + self.maxLongitudeValue) / 2.0f; // This is very wrong ! Do I really need a if?
		MKCoordinateSpan span;
		span.latitudeDelta = fabs(self.minLatitudeValue - self.maxLatitudeValue);
		span.longitudeDelta = fabs(self.minLongitudeValue - self.maxLongitudeValue);
		self.coordinateRegion = MKCoordinateRegionMake(center, span);
	}
	return coordinateRegion;
}

/****************************************************************************/
#pragma mark 

- (NSArray *) sortedStations
{
    return [self.stations sortedArrayUsingDescriptors:[NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES] autorelease]]];
}

@end