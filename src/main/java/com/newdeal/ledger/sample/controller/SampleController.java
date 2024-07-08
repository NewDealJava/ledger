package com.newdeal.ledger.sample.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.newdeal.ledger.sample.dto.SampleDto;
import com.newdeal.ledger.sample.service.SampleService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/sample")
@RequiredArgsConstructor
public class SampleController {
	private final SampleService sampleService;

	@GetMapping
	public String listSamples(Model model) {
		List<SampleDto> samples = sampleService.findAll();
		model.addAttribute("samples", samples);
		return "sample/list";
	}

	@GetMapping("/add")
	public String addSampleForm(Model model) {
		model.addAttribute("sample", new SampleDto());
		return "sample/add";
	}

	@PostMapping("/add")
	public String addSample(@ModelAttribute SampleDto sample) {
		sampleService.save(sample);
		return "redirect:/sample";
	}

	@GetMapping("/edit/{id}")
	public String editSampleForm(@PathVariable Long id, Model model) {
		SampleDto sample = sampleService.findById(id);
		model.addAttribute("sample", sample);
		return "sample/edit";
	}

	@PostMapping("/edit")
	public String editSample(@ModelAttribute SampleDto sample) {
		sampleService.save(sample);
		return "redirect:/sample";
	}

	@GetMapping("/delete/{id}")
	public String deleteSample(@PathVariable Long id) {
		sampleService.deleteById(id);
		return "redirect:/sample";
	}

}
