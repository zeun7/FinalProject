package multi.com.finalproject.minihome.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import multi.com.finalproject.minihome.service.MiniHomeService;

@Component
public class ResetVTodayScheduler {
	@Autowired
	MiniHomeService service;
	
	// Every day at 00:00 AM
	@Scheduled(cron = "0 0 0 * * ?")
	public void resetVToday() {
	    service.resetVTodayForAll();
	}
}