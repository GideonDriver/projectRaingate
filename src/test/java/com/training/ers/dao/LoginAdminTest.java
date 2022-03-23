package com.training.ers.dao;

import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

import io.github.bonigarcia.wdm.WebDriverManager;

public class LoginAdminTest {
	String browserName = "chrome";
	WebDriver driver;

	@BeforeEach
	public void setup() {
		if (browserName.equals("edge")) {
			WebDriverManager.edgedriver().setup();
			driver = new EdgeDriver();
		} else if (browserName.equals("firfox")) {
			// Cannot run Firefox since I don't have it installed
			WebDriverManager.firefoxdriver().setup();
			driver = new FirefoxDriver();
		} else if (browserName.equals("chrome")) {
			WebDriverManager.chromedriver().setup();
			driver = new ChromeDriver();
		}
	}
	
	@AfterEach
	public void tearDown() {
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			System.out.println("Error");
		}

		driver.close();
		driver.quit();
	}

	@Test
	public void testProjectOne() {
		driver.get("http://localhost:8080/raingate-ers-revature/login.html");
		driver.manage().window().maximize();

		driver.findElement(By.xpath("//*[@id=\"username\"]")).sendKeys("Admin");
		driver.findElement(By.xpath("//*[@id=\"password\"]")).sendKeys("adminpassword");
		driver.findElement(By.xpath("//*[@id=\"submit\"]")).click();
		assertTrue(driver.findElement(By.xpath("/html/body/center/h3[2]/a")).isDisplayed());
	}

}
